# encoding: utf-8
s = File.read "#{Rails.root}/db/medlemsliste2.txt"
m = s.scan(/^\d+$.*?(?=^\d+$|^Voice)/m)
mem_array = m.map { |e| e.split("\n") }

mem_array.each do |lines|
  lines.delete_if{|l| l == ''}
  Member.create! id: lines[0], name: lines[1], address: lines[2],
          birthdate: lines[3..-1].find{|l| l =~ /^Født: (.*)$/} && $1,
          left_on: (lines[3..-1].find { |l| l =~ /\*Avsluttet: (.*)$/ } && $1),
          postal_code: lines[3..-1].find{|l| l =~ /^(\d+) (.*)$/} && $1,
          post_office: lines[3..-1].find{|l| l =~ /^(\d+) (.*)$/} && $2,
          joined_on: lines[3..-1].find{|l| l =~ /^Innmeldt: (.*)$/} && $1,
          female: lines[3..-1].find{|l| l =~ /^Kjønn: (.*)$/} && $1 == 'Kvinne' || false,
          email: lines[3..-1].find{|l| l =~ /^EPost: (.*)$/} && $1,
          mobile: lines[3..-1].find{|l| l =~ /^Mobil\/Faksnr: (.*?)(?:[, \/]+(.*))?$/} && $1,
          guardian_1_mobile: lines[3..-1].find{|l| l =~ /^Mobil\/Faksnr: (.*?)(?:, (.*))?$/} && $2
end
