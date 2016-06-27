require 'invoicing/ledger_item/pdf_generator'
module StripeHelper
    class MyInvoiceGenerator < Invoicing::LedgerItem::PdfGenerator
      def initialize(invoice)
        @invoice = invoice
      end
      attr_reader :invoice

      def render(file)
        Prawn::Document.generate(file) do |pdf|
          render_headers(pdf)
          render_details(pdf)
          render_summary(pdf)
        end
      end

      private

      def render_headers(pdf)
        pdf.table([ [I18n.t('invoice_title') ] ], width: 540, cell_style: {padding: 0}) do
          row(0..10).borders = []
          cells.column(0).style(size: 20, font_style: :bold, valign: :center)
        end
      end

      # Renders details about pdf. Shows company name, invoice date and id
      def render_details(pdf)
        pdf.move_down 10
        pdf.stroke_horizontal_rule
        pdf.move_down 15
        
        company_name = User.find(invoice.sender_id).company_name
        billing_details =
          pdf.make_table([ [I18n.t('billed_to'),company_name] ],
                         column_widths: [55, 300], cell_style: {padding: 0}) do
          row(0..10).style(size: 9, borders: [])
          row(0).column(1).style(font_style: :bold)
          cells.columns(0..1).align = :left
        end

        invoice_date = I18n.l(invoice.created_at, format: :default)
        invoice_id   = invoice.id.to_s
        invoice_details =
          pdf.make_table([ [I18n.t('invoice_date'), invoice_date], [I18n.t('invoice_no'), invoice_id] ],
                         width: 185, position: :right, cell_style: {padding: 5, border_width: 0.5}) do
          row(0..10).style(size: 9)
          row(0..10).column(0).style(font_style: :bold)
        end

        pdf.table([ [billing_details, invoice_details] ], cell_style: {padding: 0}) do
          row(0..10).style(borders: [])
        end
      end

      # Renders details of invoice in a tabular format. Renders each line item, and
      # unit price, and total amount, along with tax. It also displays summary,
      # ie total amount, and total price along with tax.
      def render_summary(pdf)
        pdf.move_down 25
        pdf.text I18n.t('invoice_summary'), size: 12, style: :bold
        pdf.stroke_horizontal_rule

        table_details = [ [I18n.t('item_no'), I18n.t('description'), I18n.t('unit_price'), I18n.t('total_price')] ]
        invoice.line_items.each_with_index do |line_item, index|
          net_amount = line_item.net_amount_formatted
          table_details <<
            [index + 1, line_item.description, net_amount, net_amount]
        end
        pdf.table(table_details, column_widths: [40, 380, 60, 60], header: true,
                  cell_style: {padding: 5, border_width: 0.5}) do
          row(0).style(size: 10, font_style: :bold)
          row(0..100).style(size: 9)

          cells.columns(0).align = :right
          cells.columns(2).align = :right
          cells.columns(3).align = :right
          row(0..100).borders = [:top, :bottom]
        end

        summary_details = [
          [I18n.t('subtotal'), invoice.net_amount_formatted],
          [I18n.t('tax'),      invoice.tax_amount_formatted],
          [I18n.t('total'),    invoice.total_amount_formatted]
        ]
        pdf.table(summary_details, column_widths: [480, 60], header: true,
                  cell_style: {padding: 5, border_width: 0.5}) do
          row(0..100).style(size: 9, font_style: :bold)
          row(0..100).borders = []
          cells.columns(0..100).align = :right
        end

        pdf.move_down 25
        pdf.stroke_horizontal_rule
      end

      def recipient_name
        invoice.recipient.respond_to?(:name) ? invoice.recipient.name : ''
      end
    end
end
