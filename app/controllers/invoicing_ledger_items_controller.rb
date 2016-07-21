# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Handles **InvoicingLedgerItem model** as used by stripe and invoicing gems.  
# Only accessible by users with *admin* role. 
# This controller support full localization (routes, fields and data).  
#![Class Diagram](file/doc/diagram/invoicing_ledger_items_controller_diagram.png)
class InvoicingLedgerItemsController < ApplicationController
  load_and_authorize_resource
  # Displays invoicing_ledger_items list with bootstrap table sortable format.  
  # It is called with or without *recipient_id* param
  # @return [index.html.erb] the index web page
  # @rest_url GET(/:locale)/invoicing_ledger_items(.:format)
  # @path invoicing_ledger_items_list
#Index est appelé dans deux contextes: sans param,  avec un param
  def index
    if params[:recipient_id] != nil
      @invoicing_ledger_items = InvoicingLedgerItem.where(recipient_id:  params[:recipient_id])
    else
      @invoicing_ledger_items = InvoicingLedgerItem.all  
    end      
  end
  # Displays the invoicing_ledger_item 
  # @return [show.html.erb] the show web page. 
  # @rest_url GET(/:locale)/invoicing_ledger_items/:id(.:format)
  # @path invoicing_ledger_item
  def show
  end
  # Delete the invoicing_ledger_item from the database
  # @return [index.html.erb] the index web page
  # @rest_url DELETE(/:locale)/invoicing_ledger_items/:id(.:format)
  def destroy
    @invoicing_ledger_item.destroy
    respond_to do |format|
      format.html { redirect_to invoicing_ledger_items_url, notice: 'invoicing_ledger_item was successfully destroyed.' }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def invoicing_ledger_item_params
    params.require(:invoicing_ledger_item).permit(:sender_id, :recipient_id)
  end
end
