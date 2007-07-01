#! /usr/bin/ruby -w

require 'rubygems'
require 'uri'
require 'hpricot'
require 'net/http'
require 'cgi'

USER = 'shingara'
PASS = 'bond007'


class NodeMap
  def initialize (x, y, type)
    @x = x
    @y = y
    @type = type
  end
end

PROXY_ADR = 'proxy.insia.org'
PROXY_PORT = 3128


u_forum = URI::HTTP.build({:host => 'conquest-lys.net',
                           :path => '/forum_v2/login.php'})

#Net::HTTP::Proxy(PROXY_ADR, PROXY_PORT).start('conquest-lys.net') { |http|
Net::HTTP.start('conquest-lys.net') { |http|
  
  po = Net::HTTP::Post.new(u_forum.path)
  po.form_data = { 'username' => USER, 'password' => PASS, 
                  'autologin' => 'on', 'redirect' => "lys/loguser.php?username=#{USER}"}
  a = http.request(po)
  po = a['Set-Cookie']
  cook = {}
  
  b = a['Set-Cookie'].gsub(/expires=(.+)GMT;/, '')
  b.split(',').each do |c| 
    c.split(';').each do |s| 
      v = s.split('=')
      unless v[0] =~ /expires/ || v[0] =~ /path/
        cook[v[0].strip] = v[1]
      end
    end
  end
  string_cookie = ''
  count = 1
  cook.each_pair { |k,v|
    string_cookie += "#{k}=#{v}"
    string_cookie += "; " unless count == cook.size
    count += 1
  }
  p string_cookie
  
  po = Net::HTTP::Post.new('/forum_v2/lys/loguser.php')
  po.form_data = { 'username' => USER }
  po.add_field 'Cookie', string_cookie
  
  a = http.request(po)

  po = Net::HTTP::Post.new('/lys_v2/index.php')
  po.form_data = { 'mod' => 'logon', 'Nom' => USER, 'Password' => 'oui', 'Passchange' => '1'}
  po.add_field 'Cookie', string_cookie

  p "cookies : #{po['Cookie']}"
  a = http.request(po)
  cook = CGI::Cookie::parse a['Set-Cookie']
  p cook

}

puts 'end'
res = Net::HTTP.post_form u_forum, { 'username' => USER, 'password' => PASS, 
                                      'autologin' => 'on', 
                                      'redirect' => "lys/loguser.php?username=#{USER}"}

puts res['Location']

f = open('1.html', 'w')
f << res.body
f.close

f = open('1.txt', 'w')
res.each do |k, v| 
  f << " #{k} : #{v} \n"
end
f.close

u_forum2 = URI::HTTP.build({:host => 'conquest-lys.net',
                           :path => '/forum_v2/lys/loguser.php'})

res = Net::HTTP.post_form u_forum2, { 'username' => USER}
#phpsessid = /PHPSESSID=(.+);/.match(res['set-cookie'])[1]

puts res['Location']
f = open('2.html', 'w')
f << res.body
f.close

f = open('2.txt', 'w')
res.each do |k, v| 
  f << " #{k} : #{v} \n"
end
f.close


u = URI::HTTP.build({:host => 'conquest-lys.net',
                     :path => '/lys_v2/index.php'})
res = Net::HTTP.post_form u, { 'mod' => 'logon', 'Nom' => USER, 'Password' => PASS, 'Passchange' => '1'}

puts res['Location']
f = open('3.html', 'w')
f << res.body
f.close
f = open('3.txt', 'w')
res.each do |k, v| 
  f << " #{k} : #{v} \n"
end
f.close

phpsessid = /PHPSESSID=(.+);/.match(res['set-cookie'])[1]

res = Net::HTTP.post_form u, { 'mod' => 'jouer', 'PHPSESSID' => phpsessid}
# irb(main):034:0> res['set-cookie']
  # => "PHPSESSID=5oqipbdvt1v1cnm2o9bo9d7775; path=/"
  #

h = Hpricot.parse(open('map.php.html', 'r'))
b = h.get_element_by_id('plateau').children_of_type('tbody')[0]
p b.class
list_x = []
list_node = []
b.each_child_with_index do |n, i|
  p i
 
  next unless n.elem?
  if n.get_attribute('id') == 'p_tdx'
    n.children_of_type('td').each do |l|
      l.children_of_type('div').each do |m|
         list_x << m.to_plain_text
      end
    end
  else
    c = n.children_of_type('td')
    y = 0
    c.each_with_index do |l, k|
      p l.get_attribute('id')
      if l.get_attribute('id') == 'p_tdy' 
        y = l.to_plain_text
      else
        list_node << NodeMap.new((list_x[k - 1]), y, l.get_attribute('background'))
      end
    end unless c.nil?
  end

end
p list_x
p list_node
