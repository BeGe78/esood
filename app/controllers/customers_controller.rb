class CustomersController < ApplicationController
    require 'world_bank'
    require 'rserve/simpler'
    
    def new
        c = Rserve::Connection.new
        @results = WorldBank::Data.country('france').indicator('NY.GDP.MKTP.CD').dates('2010:2014').fetch 
        v = Array.new
        for d in 0..4
          v[d] = @results[d].value.to_f
        end
        gon.data4 = v
        c.assign("vect", v)
        moyenne = c.eval("mean(vect)")
        puts(moyenne.to_ruby)
        y = Array.new
        for d in 0..4
          y[d] = @results[d].date.to_f
        end
        c.assign("year", y)
#        puts(y)
#        plot = c.eval("plot(year,vect)")
    end
    def create
        render plain: params[:customer].inspect
    end    
end
