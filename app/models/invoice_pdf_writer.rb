# encoding: utf-8
require 'iconv'
require 'pdf_writer'

class Invoice
  ORGANIZATION = 'Voice Barne- og Ungdomskor'
  ADDRESS = 'Håkons vei 73C'.encode(Encoding::ISO_8859_1)
  POST_ADDRESS = '1470 LØRENSKOG'.encode(Encoding::ISO_8859_1)
  PRICE = '750'
  INVOICE_DATE = Date.today
  DUE_DATE = 14.days.from_now

  def initialize(member)
    @member = member
  end

  def pdf
    pdf_writer = PdfWriter.new stream = StringIO.new, title, :mm

    iconv = Iconv.new('ISO-8859-1', 'UTF-8')

    pdf_writer.newPage
    pdf_writer.writeText(7, 288, 'Faktura', fontsize: 18, bold: true)

    pdf_writer.writeText(80, 280, ORGANIZATION, fontsize: 18, bold: true)
    pdf_writer.writeText(80, 275, "#{ADDRESS}, #{POST_ADDRESS}".encode(Encoding::ISO_8859_1), fontsize: 12)
    pdf_writer.writeText(90, 270, 'NO 996 192 733', :fontsize => 10)
    # Encoding.list.each.with_index do |e, i|
    #   pdf_writer.writeText(90, 265 - (i * 5), e.names.join(", "), fontsize: 10)
    # end

    height = 250
    (@member.name + "\n" + @member.address).split("\n").each_with_index do |line, i|
      pdf_writer.writeTxtBox(height, 20, 100, iconv.iconv(line))
      height -= 5
    end
    pdf_writer.writeTxtBox(250, 110, 200, ORGANIZATION)
    pdf_writer.writeTxtBox(245, 110, 200, ADDRESS.encode(Encoding::ISO_8859_1))
    pdf_writer.writeTxtBox(240, 110, 200, POST_ADDRESS)

    # pdf_writer.writeText(160, 250, "Ordrenummer #{'%04i' % @order.id}")
    pdf_writer.writeText(160, 245, "Fakturanummer #{'%04i' % invoice_no}")
    pdf_writer.writeText(160, 240, "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}")
    pdf_writer.writeText(160, 235, "Forfallsdato #{DUE_DATE.strftime('%d.%m.%Y')}")

    height = 211
    pdf_writer.writeTxtBox(height, 10, 100, 'Beskrivelse')
    pdf_writer.writeTxtBox(height, 110, 130, 'Antall')
    pdf_writer.writeTxtBox(height, 130, 170, 'Pris per stk.')
    pdf_writer.writeTxtBox(height, 170, 210, 'SUM')

    height -= 1

    pdf_writer.writeLine(10, height, 200, height)
    height -= 5

    pdf_writer.writeTxtBox(height, 10, 100, iconv.iconv('Semesteravgift'))
    pdf_writer.writeTxtBox(height, 110, 130, '1')
    pdf_writer.writeTxtBox(height, 130, 170, "kr #{'%6.2f' % PRICE}")
    pdf_writer.writeTxtBox(height, 170, 210, "kr #{'%6.2f' % PRICE}")
    height -= 5

    height += 2
    pdf_writer.writeLine(10, height, 200, height)
    height -= 6

    pdf_writer.writeText(130, height, 'Delsum', :fontsize => 10, :bold => true)
    pdf_writer.writeText(170, height, 'kr ' + '%6.2f' % PRICE, fontsize: 10,bold: true)
    height -= 5

    # pdf_writer.writeText(130, height, 'MVA 25%')
    # pdf_writer.writeText(170, height, "kr #{'%6.2f' % @order.sales_tax}")
    # height -= 5

    # pdf_writer.writeText(130, height, 'Shipping')
    # pdf_writer.writeText(170, height, "kr #{'%6.2f' % @order.shipping_price}")
    # height -= 5

    pdf_writer.writeText(130, height, "TOTALT", :bold => true)
    pdf_writer.writeText(170, height, "kr #{'%6.2f' % PRICE}")
    height -= 5

    pdf_writer.writeText(82, 106, "kr #{'%.2f' % PRICE}")

    pdf_writer.writeText(173, 95, DUE_DATE.strftime('%d.%m.%Y'))

    # pdf_writer.writeText(18, 90, "Ordrenummer #{'%04i' % @order.id}")
    pdf_writer.writeText(18, 85, "Fakturanummer #{'%04i' % invoice_no}")
    pdf_writer.writeText(18, 80, "Fakturadato #{INVOICE_DATE.strftime('%d.%m.%Y')}")

    height = 60
    (@member.name + "\n" + @member.address).split("\n").each_with_index do |line, i|
      pdf_writer.writeTxtBox(height, 15, 100, line)
      height -= 5
    end

    pdf_writer.writeTxtBox(60, 115, 200, iconv.iconv(ORGANIZATION))
    pdf_writer.writeTxtBox(55, 115, 200, ADDRESS)
    pdf_writer.writeTxtBox(50, 115, 200, POST_ADDRESS)

    height = 22
    pdf_writer.writeText(85, height, PRICE)
    pdf_writer.writeText(107, height, '%02i' % PRICE)
    pdf_writer.writeText(132, height, '1310 26 29765')

    pdf_writer.endPage

    pdf_writer.writeEnd

    stream.string
  end

  def invoice_no
    @member.id + 20
  end

  def title
    "Faktura #{'%04d' % invoice_no} #{@member.name}"
  end
end
