class InvoicingLedgerItemsController < ApplicationController
  load_and_authorize_resource

  # GET /roles
  # GET /roles.json
  def index
    @invoicing_ledger_items = InvoicingLedgerItem.all
  end

  # GET /roles/1
  # GET /roles/1.json
def show
  if !@invoicing_ledger_item.recipient_id.present?
    @associated_mail = "None"
  else
    @associated_mail = User.find(@invoicing_ledger_item.recipient_id).email
  end
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
