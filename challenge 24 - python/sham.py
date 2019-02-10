import itertools
import string

from Crypto.Hash import MD2,MD5,SHA,SHA256,SHA512

def bruteforce(charset, maxlength):
    return (''.join(candidate)
        for candidate in itertools.chain.from_iterable(itertools.product(charset, repeat=i)
        for i in range(6, maxlength + 1)))
        
sham="757c479895d6845b2b0530cd9a2b11"
print "we are going to crack SHAM hash now..."

found_md2,found_md5,found_sha1,found_sha256,found_sha512=0,0,0,0,0
	
for attempt in bruteforce(string.letters+string.digits, 10):	
	
	if found_md2==0:
		m = MD2.new()
		m.update(attempt)
		md2=m.hexdigest()
		if md2[0:6]==sham[0:6]:
			print "found: " + attempt + ":" + md2 + " - (MD2)"
			found_md2=1
			s_md2=attempt
	
	if found_md5==0:
		m = MD5.new()
		m.update(attempt)
		md5=m.hexdigest()
		if md5[6:12]==sham[6:12]:
			print "found: " + attempt + ":" + md5 + " - (MD5)"
			found_md5=1
			s_md5=attempt
		
	if found_sha1==0:	
		m = SHA.new()
		m.update(attempt)
		sha1=m.hexdigest()
		if sha1[12:18]==sham[12:18]:
			print "found: " + attempt + ":" + sha1 + " - (SHA1)"
			found_sha1=1
			s_sha=attempt
			
	if found_sha256==0:	
		m = SHA256.new()
		m.update(attempt)
		sha256=m.hexdigest()
		if sha256[18:24]==sham[18:24]:
			print "found: " + attempt + ":" + sha256 + " - (SHA256)"
			found_sha256=1
			s_sha256=attempt
			
	if found_sha512==0:	
		m = SHA512.new()
		m.update(attempt)
		sha512=m.hexdigest()
		if sha512[24:30]==sham[24:30]:
			print "found: " + attempt + ":" + sha512 + " - (SHA512)"
			found_sha512=1
			s_sha512=attempt
			
	if found_md2+found_md5+found_sha1+found_sha256+found_sha512==5:
		print "SHAM Hash cracked: "+s_md2+s_md5+s_sha+s_sha256+s_sha512
		break

