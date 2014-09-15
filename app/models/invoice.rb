# encoding: utf-8
require 'prawn/measurement_extensions'

class Invoice
  ORGANIZATION = 'Voice Barne- og Ungdomskor'
  ADDRESS = 'Håkons vei 73C'
  POST_ADDRESS = '1470 LØRENSKOG'
  PRICE = '750'
  INVOICE_DATE = Date.today
  DUE_DATE = 14.days.from_now

  def initialize(member)
    @member = member
  end

  def pdf
    member = @member
    Prawn::Document.new page_size: 'A4', page_layout: :portrait,
        bottom_margin: 0.0.cm, left_margin: 0.0.cm do
      draw_text 'Faktura', at: [7.mm, 288.mm], size: 18, style: :bold

      draw_text ORGANIZATION, at: [80.mm, 280.mm], size: 18, style: :bold
      draw_text "#{ADDRESS}, #{POST_ADDRESS}", at: [80.mm, 275.mm], size: 12
      draw_text 'NO 996 192 733', at: [90.mm, 270.mm], size: 10

      height = 250
      (member.name + "\n" + member.address).split("\n").each_with_index do |line, i|
        draw_text line, at: [height.mm, 20.mm]
        height -= 5
      end

      draw_text ORGANIZATION, at: [250.mm, 110.mm]
      draw_text ADDRESS, at: [245.mm, 110.mm]
      draw_text POST_ADDRESS, at: [240.mm, 110.mm]

      # # draw_text 160, 250, "Ordrenummer #{'%04i' % @order.id}")
    # draw_text 160, 245, "Fakturanummer #{'%04i' % invoice_no}")
    # draw_text 160, 240, "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}")
    # draw_text 160, 235, "Forfallsdato #{DUE_DATE.strftime('%d.%m.%Y')}")
    #
    # height = 211
    # draw_text height, 10, 100, 'Beskrivelse')
    # draw_text height, 110, 130, 'Antall')
    # draw_text height, 130, 170, 'Pris per stk.')
    # draw_text height, 170, 210, 'SUM')
    #
    # height -= 1
    #
    # pdf_writer.writeLine(10, height, 200, height)
    # height -= 5
    #
    # draw_text height, 10, 100, iconv.iconv('Semesteravgift'))
    # draw_text height, 110, 130, '1')
    # draw_text height, 130, 170, "kr #{'%6.2f' % PRICE}")
    # draw_text height, 170, 210, "kr #{'%6.2f' % PRICE}")
    # height -= 5
    #
    # height += 2
    # pdf_writer.writeLine(10, height, 200, height)
    # height -= 6
    #
    # draw_text 130, height, 'Delsum', :fontsize => 10, :bold => true)
    # draw_text 170, height, 'kr ' + '%6.2f' % PRICE, fontsize: 10,bold: true)
    # height -= 5
    #
    # # draw_text 130, height, 'MVA 25%')
    # # draw_text 170, height, "kr #{'%6.2f' % @order.sales_tax}")
    # # height -= 5
    #
    # # draw_text 130, height, 'Shipping')
    # # draw_text 170, height, "kr #{'%6.2f' % @order.shipping_price}")
    # # height -= 5
    #
    # draw_text 130, height, "TOTALT", :bold => true)
    # draw_text 170, height, "kr #{'%6.2f' % PRICE}")
    # height -= 5
    #
    # draw_text 82, 106, "kr #{'%.2f' % PRICE}")
    #
    # draw_text 173, 95, DUE_DATE.strftime('%d.%m.%Y'))
    #
    # # draw_text 18, 90, "Ordrenummer #{'%04i' % @order.id}")
    # draw_text 18, 85, "Fakturanummer #{'%04i' % invoice_no}")
    # draw_text 18, 80, "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}")
    #
    # height = 60
    # (@member.name + "\n" + @member.address).split("\n").each_with_index do |line, i|
    #   draw_text height, 15, 100, line)
    #   height -= 5
    # end
    #
    # draw_text 60, 115, 200, iconv.iconv(ORGANIZATION))
    # draw_text 55, 115, 200, ADDRESS)
    # draw_text 50, 115, 200, POST_ADDRESS)
    #
    # height = 22
    # draw_text 85, height, PRICE)
    # draw_text 107, height, '%02i' % PRICE)
    # draw_text 132, height, '1310 26 29765')

    end.render
  end

  def invoice_no
    @member.id + 20
  end

  def title
    "Faktura #{'%04d' % invoice_no} #{@member.name}"
  end
end

  # text I18n.t(:time_sheet, :locale => invoice.customer.locale),
  #     :size => 24, :style => :bold, :align => :right
  #
  # text "#{invoice.works.map(&:started_on).sort.first} #{I18n.t(:to, :locale => invoice.customer.locale)} #{invoice.invoice_date}", :size => 18, :align => :right
  #
  # text invoice.project.name, :size => 18, :align => :right
  # text(invoice.customer.name == invoice.project.name ? ' ' : invoice.customer.name,
  #     :size => 18, :align => :right)
  #
  # move_down 20
  #
  # if invoice.project.work_categories.any?
  #   hours_col_width_1 = invoice.customer.show_non_billable_hours_in_invoice ? 58 : 55
  #
  #   table([
  #       [I18n.t(:category, :locale => invoice.customer.locale),
  #           invoice.customer.show_non_billable_hours_in_invoice? ? I18n.t(:billable, :locale => invoice.customer.locale) : I18n.t(:hours, :locale => invoice.customer.locale),
  #           invoice.customer.show_non_billable_hours_in_invoice ? I18n.t(:non_billable, :locale => invoice.customer.locale) : nil,
  #       ].compact,
  #       *invoice.works.sort_by { |w| w.work_category.try(:name).to_s }.
  #           group_by(&:work_category).select{|wc, works| invoice.customer.show_non_billable_hours_in_invoice? || works.select(&:billable).any?}.map do |wc, works|
  #         [
  #             wc.try(:name) || I18n.t(:general),
  #             works.select(&:billable).any? ? '%.2f' % works.select(&:billable).reduce(0.0) { |tot, w| tot + w.rounded_hours }.to_s : '',
  #             invoice.customer.show_non_billable_hours_in_invoice? ? ((works.reject(&:billable).any?) ? '%.2f' % works.reject(&:billable).reduce(0.0) { |tot, w| tot + w.rounded_hours }.to_s : '') : nil,
  #         ].compact
  #       end,
  #
  #       [I18n.t(:total, :locale => invoice.customer.locale), '%.2f' % invoice.works.select(&:billable).map(&:rounded_hours).reduce(BigDecimal('0'), &:+),
  #           invoice.customer.show_non_billable_hours_in_invoice ? '%.2f' % invoice.works.reject(&:billable).map(&:rounded_hours).reduce(BigDecimal('0'), &:+) : nil
  #       ].compact,
  #   ], :width => bounds.width, :header => true,
  #       :row_colors => %w(F8F8F8 FFFFFF),
  #       :column_widths => {1 => hours_col_width_1, 2 => hours_col_width_1}) do
  #     row(0).font_style = :bold
  #     row(0).valign = :bottom if invoice.customer.show_non_billable_hours_in_invoice
  #     rows(1..-1).border_width = 0.3
  #     row(-1).font_style = :bold
  #     columns(1..2).align = :center
  #   end
  #   move_down 30
  # end
  #
  #
  # font_size 8
  #
  # hours_width = invoice.customer.show_non_billable_hours_in_invoice ? 57 : 52
  # table([[I18n.t(:date_str, :locale => invoice.customer.locale), 'Person',
  #     I18n.t(:description, :locale => invoice.customer.locale),
  #     invoice.project.work_categories.any? ? I18n.t(:category, :locale => invoice.customer.locale) : nil,
  #     invoice.customer.show_non_billable_hours_in_invoice ? I18n.t(:billable, :locale => invoice.customer.locale) : I18n.t(:hours, :locale => invoice.customer.locale),
  #     invoice.customer.show_non_billable_hours_in_invoice ? I18n.t(:non_billable, :locale => invoice.customer.locale) : nil,
  # ].compact,
  #     *([nil] + (invoice.customer.show_non_billable_hours_in_invoice ? invoice.works : invoice.works.billable).order(:started_on, :start_time, :completed_at)).each_cons(2).map do |prev_w, w|
  #       [
  #           prev_w.nil? || (w.started_on != prev_w.started_on) ? w.started_on.to_s : '',
  #           w.user.login,
  #           w.description_str(' - '),
  #           invoice.project.work_categories.any? ? w.work_category.try(:name).to_s : nil,
  #           w.billable ? '%.2f' % w.rounded_hours : '',
  #           invoice.customer.show_non_billable_hours_in_invoice ? (!w.billable ? '%.2f' % w.rounded_hours : '') : nil,
  #       ].compact
  #     end,
  #     [
  #         '', '',
  #         I18n.t(:total, :locale => invoice.customer.locale),
  #         invoice.project.work_categories.any? ? '' : nil,
  #         '%.2f' % invoice.works.select(&:billable).map(&:rounded_hours).reduce(BigDecimal('0'), &:+),
  #         invoice.customer.show_non_billable_hours_in_invoice ? '%.2f' % invoice.works.reject(&:billable).map(&:rounded_hours).reduce(BigDecimal('0'), &:+) : nil,
  #     ].compact,
  #
  # ], :width => bounds.width, :header => true,
  #     :row_colors => %w(F8F8F8 FFFFFF),
  #     :column_widths => {0 => 54, 1 => 36, 3 => hours_width, 4 => hours_width}) do
  #   row(0).font_style = :bold
  #   row(0).valign = :bottom
  #   rows(1..-1).border_width = 0.3
  #   row(-1).font_style = :bold
  #   columns(3..5).align = :center
  # end
  #
  # create_stamp('preview') do
  #   transparent 0.25 do
  #     rotate(30, :origin => [-5, -5]) do
  #       stroke_color 'FF3333'
  #       stroke_ellipse [435, 295], 330, 120
  #       stroke_color '000000'
  #       fill_color '993333'
  #       font('Times-Roman') do
  #         draw_text 'Preview', :at => [160, 240], :size => 180
  #       end
  #       fill_color '000000'
  #     end
  #   end
  # end
  # repeat(:all) do
  #   stamp 'preview' unless invoice.closed?
  # end
  #
