class InvoicingLedgerItemsController < ApplicationController
  load_and_authorize_resource

#Index est appelé dans deux contextes: sans param,  avec un param
  def index
      if params[:recipient_id] != nil
         @invoicing_ledger_items = InvoicingLedgerItem.where(recipient_id:  params[:recipient_id])
      else
        @invoicing_ledger_items = InvoicingLedgerItem.all  
      end
      
  end

  # GET /roles/1
  # GET /roles/1.json
def show

end
  def destroy
    @invoicing_ledger_item.destroy
    respond_to do |format|
      format.html { redirect_to invoicing_ledger_items_url, notice: 'invoicing_ledger_item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoicing_ledger_item_params
      params.require(:invoicing_ledger_item).permit(:sender_id, :recipient_id)
    end
end
