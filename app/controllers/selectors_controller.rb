class SelectorsController < ApplicationController #insteadof  Admin::BaseController
    require 'world_bank'       #world bank API
    require 'rserve/simpler'   #R API
    require 'action_view'      #for number_to_human
    include ActionView::Helpers::NumberHelper
    autocomplete :indicator, :id1, :full => true
    autocomplete :country, :name, :full => true
# override la méthode standard pour sélectionner la langue dans les tables indicators et countries   
    def get_autocomplete_items(parameters)
        if (parameters[:model] == Indicator or parameters[:model] == Country)
            items = active_record_get_autocomplete_items(parameters)        
            items = items.accessible_by(current_ability).where(:language => I18n.locale)
        else
            items = active_record_get_autocomplete_items(parameters)
        end    
    end

    def new
        @indicator_base = Indicator.accessible_by(current_ability).where(language: I18n.locale).order(:topic , :id1).all
        @country_base = Country.accessible_by(current_ability).accessible_by(current_ability).where(language: I18n.locale).order(:type , :name).all
        @selector = Selector.new
    end
    def create
        begin
        @indicator_base = Indicator.where(language: I18n.locale).order(:topic , :id1).all
        @country_base = Country.where(language: I18n.locale).order(:type , :name).all
        @selector = Selector.new(selector_params)
        @indicator = params[:fake_indicator]
        id_country1 = params[:selector].values[1]
        @country1 = Country.find(id_country1).iso2code
        @country1_name = Country.find(id_country1).name
        id_country2 = params[:selector].values[2]
        @country2 = Country.find(id_country2).iso2code
        @country2_name = Country.find(id_country2).name
        rescue ActiveRecord::RecordNotFound => e
           flash[:notice] = t('wrong_parameter')
           redirect_to new_selector_path and return
        end
        @period = params[:selector].values[3]
#        render plain: params[:selector].inspect
        begin
        @results1 = WorldBank::Data.country(@country1).indicator(@indicator).dates(@period).fetch # on peut rajouter .language('fr') mais il faut le mettre avant le fetch mais il y a un bug
        @results2 = WorldBank::Data.country(@country2).indicator(@indicator).dates(@period).fetch
        rescue Exception => e
           flash[:notice] = t('wrong_worldbank_fetch')
           redirect_to new_selector_path and return
        end
        v = Array.new
        v1 = Array.new
        v2 = Array.new
        y = Array.new
        y_to_i = Array.new
        for d in 0..(@results1.size - 1)
          @percent = false                                               # percentage handling to get significative digit
          if @indicator[@indicator.length - 3, @indicator.length] == '.ZS'
              then @percent = true
          end
          if @percent
              v1[d] = (@results1[(@results1.size - 1) - d].value.to_f)    # series extraction, f for percentage else integer
              v2[d] = (@results2[(@results1.size - 1) - d].value.to_f) 
          else
              v1[d] = (@results1[(@results1.size - 1) - d].value.to_i)
              v2[d] = (@results2[(@results1.size - 1) - d].value.to_i)
          end
          y[d] = @results1[(@results1.size - 1) - d].date
          y_to_i[d] = y[d].to_i                          # R needs integers for correct calculus
        end
        l = [v1.max.to_s.length, v1.max.to_s.length].max # l contains the length of the biggest integer
#   compute the dividing scale        
         @scale = case l                                 
          when 1..6 then 1
          when 7..9 then 1000
          when 10..12 then 1000000
          else 1000000000  
        end
        @scale = 1 if @percent                           # rectify scale for percentage
        v1.collect! {|i| i / @scale}                     # apply the scale
        v2.collect! {|i| i / @scale}
        v = [v1,v2]
        @precision = 0
        @precision = 2 if @percent
#  X axis positioning        
        @xaxispos = 'bottom'
        if v1.min < 0 or v2.min < 0 
            @xaxispos = 'center'
        end    
#title scaffolding - need to take the localized names to bypass language bug in world_bank API
        @country1_local = Country.where(iso2code: @country1, language: I18n.locale).take
        @country2_local = Country.where(iso2code: @country2, language: I18n.locale).take
        @indicator_local = Indicator.where(id1: @indicator, language: I18n.locale).take
        puts (@country1_local)
        @title = t('compare') << ": " << @country1_local.name << "/" << @country2_local.name \
                 << " - " << t('for_indicator') << ": " << @indicator_local.name \
                 << " - " << t('with_scale') << ": 1/" << number_with_delimiter(@scale, locale: :fr)
# send data in js format        
        gon.push({                                       
                  :title => @title,
                  :data => v,
                  :data1 => v1,
                  :data2 => v2,
                  :year => y, 
                  :country1 => @country1_local.name,
                  :country2 => @country2_local.name,
                  :indicator => @indicator_local.name,
                  :scale => @scale,
                  :xaxispos => @xaxispos
                 })
        
#__________Statistics______________
        begin
        c = Rserve::Connection.new
        c.assign("year", y_to_i)
        c.assign("vect1", v1)        
        c.assign("vect2", v2)
        @mean1 = c.eval("mean(vect1)")
        @mean2 = c.eval("mean(vect2)")
        @cor = c.eval("cor(vect1,vect2)")
        @coeflm1 = c.eval("coefficients(lm(vect1 ~ year))").as_floats
        @coeflm2 = c.eval("coefficients(lm(vect2 ~ year))").as_floats
        @coeflm3_1 = c.eval("summary(lm(vect1 ~ year))$r.squared ")
        @coeflm3_2 = c.eval("summary(lm(vect2 ~ year))$r.squared ")
        @meanrate1 = (@coeflm1[1]/@mean1.to_ruby) * 100
        @meanrate2 = (@coeflm2[1]/@mean2.to_ruby) * 100
        rescue Exception => e
           flash[:notice] = t('rserve_problem')
           redirect_to new_selector_path and return
        end
 #       render plain: @coeflm1.inspect
 #       puts(@mean1.to_ruby, @mean2.to_ruby, @cor.to_ruby, @coeflm1[1],@coeflm1[0], @coeflm2[1],@coeflm2[0],@coeflm3_1.to_ruby,@coeflm3_2.to_ruby)       
 #       plot = c.eval("plot(year,vect)")
    end

    private
    def selector_params
      params.require(:selector).permit(:indicator, :country1, :country2, :period)
    end
end
