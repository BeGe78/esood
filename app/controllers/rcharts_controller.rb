class RchartsController < ApplicationController
    require 'world_bank'
    require 'rserve/simpler'
    
    def new
        hash = {var1: [1,2,3,4], fac1: [3,4,5,6], res1: [4,5,6,7]}
        df = hash.to_dataframe
        puts (hash)
        puts (df)
        c = Rserve::Connection.new
        c1 = c.eval("library(rCharts)")
        c2 = c.eval("hair_eye = as.data.frame(HairEyeColor)")
        puts (c2.inspect)
        c3 = c.eval("rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')")
        puts (c3.inspect)

    end
    def create
        @country = params[:rchart].values[0]
        @period = params[:rchart].values[1]
#        render plain: params[:rchart]
        c = Rserve::Connection.new
        @results = WorldBank::Data.country(@country).indicator('NY.GDP.MKTP.CD').dates(@period).fetch 
#        render plain: @results.size
        v = Array.new
        y = Array.new
        for d in 0..(@results.size - 1)
          v[d] = (@results[(@results.size - 1) - d].value.to_i) / 1000000000
          y[d] = @results[(@results.size - 1) - d].date
        end
        gon.push({
                  :data => v, 
                  :year => y, 
                  :country => @results[1].raw.values_at("country")[0].values_at("value")[0], 
                  :indicator => @results[0].name
                 })
        c.assign("vect", v)
 #       moyenne = c.eval("mean(vect)")
 #       puts(moyenne.to_ruby)
        c.assign("year", y)
 #       plot = c.eval("plot(year,vect)")
    end 
  private
end
