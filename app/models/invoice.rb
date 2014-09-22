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
    invoice_no = invoice_num
    Prawn::Document.new page_size: 'A4', page_layout: :portrait,
        bottom_margin: 0.0.cm, left_margin: 0.0.cm do
      draw_text 'Faktura', at: [7.mm, 288.mm], size: 18, style: :bold

      draw_text ORGANIZATION, at: [70.mm, 280.mm], size: 18, style: :bold
      draw_text "#{ADDRESS}, #{POST_ADDRESS}", at: [80.mm, 275.mm], size: 12
      draw_text 'NO 996 192 733', at: [100.mm, 270.mm], size: 10

      height = 250
      (member.name + "\n" + member.address + "\n" + member.postal_code + "" + member.post_office).split("\n").each_with_index do |line, i|
        draw_text line, at: [20.mm, height.mm]
        height -= 5
      end

      draw_text ORGANIZATION, at: [110.mm, 250.mm]
      draw_text ADDRESS, at: [110.mm, 245.mm]
      draw_text POST_ADDRESS, at: [110.mm, 240.mm]

      # draw_text 160, 250, "Ordrenummer #{'%04i' % @order.id}")
      draw_text "Fakturanummer #{'%04i' % invoice_no}", at: [245.mm, 160.mm]
      draw_text "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}", at: [240.mm, 160.mm]
      draw_text "Forfallsdato #{DUE_DATE.strftime('%d.%m.%Y')}", at: [235.mm, 160.mm]

     height = 211
     draw_text 'Beskrivelse', at: [20.mm, height.mm]
     draw_text 'Antall', at: [120.mm, height.mm]
     draw_text 'Pris per stk.', at: [140.mm, height.mm]
     draw_text 'SUM', at: [180.mm, height.mm]

     height -= 1.mm

      stroke do
        line(20.mm, height.mm, 200.mm, height.mm)
      end
      height -= 5

    draw_text 'Semesteravgift', at: [20.mm, height.mm]
    draw_text '1', at: [120.mm, height.mm]
    draw_text "kr #{'%6.2f' % PRICE}", at: [140.mm, height.mm]
    draw_text "kr #{'%6.2f' % PRICE}", at: [180.mm, height.mm]
    height -= 5

    height += 2
      stroke do
        line(20.mm, height.mm, 200.mm, height.mm)
      end
      height -= 6

    draw_text 'Delsum', fontsize: 10, style: :bold, at: [140.mm, height.mm]
    draw_text 'kr ' + '%6.2f' % PRICE, fontsize: 10, style: :bold, at: [180.mm, height.mm]
    height -= 5

    # draw_text 'MVA 25%', at: [140.mm, height.mm]
    # draw_text "kr #{'%6.2f' % @order.sales_tax}", at: [180.mm, height.mm]
    # height -= 5

    # draw_text 130, height, 'Shipping')
    # draw_text 170, height, "kr #{'%6.2f' % @order.shipping_price}")
    # height -= 5

    draw_text "TOTALT", bold: true, at: [140.mm, height.mm]
    draw_text "kr #{'%6.2f' % PRICE}", at: [180.mm, height.mm]
    height -= 5

    draw_text "kr #{'%.2f' % PRICE}", at: [92.mm, 106.mm]

    draw_text DUE_DATE.strftime('%d.%m.%Y'), at: [173.mm, 95.mm]

    # draw_text 18, 90, "Ordrenummer #{'%04i' % @order.id}")
    draw_text "Fakturanummer #{'%04i' % invoice_no}", at: [28.mm, 85.mm]
    draw_text "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}", at: [28.mm, 80.mm]

    height = 60
    (member.name + "\n" + member.address + "\n" + member.postal_code + " " + member.post_office).split("\n").each_with_index do |line, i|
      draw_text line, at: [25.mm, height.mm]
      height -= 5
    end

    draw_text ORGANIZATION, at: [115.mm, 60.mm]
    draw_text ADDRESS, at: [115.mm, 55.mm]
    draw_text POST_ADDRESS, at: [115.mm, 50.mm]

    height = 22
    draw_text PRICE, at: [85.mm, height.mm]
    draw_text '00', at: [107.mm, height.mm]
    draw_text '1310 26 29765', at: [132.mm, height.mm]

    end.render
  end

  def invoice_num
    @member.id + 20
  end

  def title
    "Faktura #{'%04d' % invoice_num} #{@member.name}"
  end
end
