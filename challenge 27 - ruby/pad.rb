code1 = ["60c46964f83879618e2878de539f6f4a6271d716"].pack("H*").unpack("C*")
code2 = ["63c37a6ca177792092602cc553c9684b"].pack("H*").unpack("C*")
code3 = ["68d82c6bf4767f79dd617f9642d768057f63c1"].pack("H*").unpack("C*")
code4 = ["6c8a7b6ce06a3161dd6a60d755d42d4d6d67"].pack("H*").unpack("C*")
code5 = ["71c26929e96931698e2865d816d3624b687cd6"].pack("H*").unpack("C*")
code6 = ["6cda6d6df87764709c6c7bd357d361556d77"].pack("H*").unpack("C*")

keybytes=""

(0..15).each do |x|
	(0..255).each do |i|
	  a=(code1[x] ^ i).chr
	  b=(code2[x] ^ i).chr
	  c=(code3[x] ^ i).chr
	  d=(code4[x] ^ i).chr
	  e=(code5[x] ^ i).chr
	  f=(code6[x] ^ i).chr
	  s=a+b+c+d+e+f
	  if (s =~ /^[a-z ]{6}$/)!=nil
	   puts x.to_s+":"+s+" "+sprintf("0x%02x", i)
	   keybytes+=sprintf("0x%02x ", i)
	 	end
	end
end
puts "key bytes: "+keybytes

a,b,c,d,e,f="","","","","","" 
key = ["05aa0c0981181100fd080cb636bf0d25"].pack("H*").unpack("C*")
(0..15).each do |x|
	a+=(code1[x] ^ key[x]).chr
	b+=(code2[x] ^ key[x]).chr
	c+=(code3[x] ^ key[x]).chr
	d+=(code4[x] ^ key[x]).chr
	e+=(code5[x] ^ key[x]).chr
	f+=(code6[x] ^ key[x]).chr
end
puts "decrypted data:"+"\n"+"---------------"+"\n"+a+"\n"+b+"\n"+c+"\n"+d+"\n"+e+"\n"+f