import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.*;

public class pincracker
{
  	public static void main(String[] args)
  	{
  		int y = do_crypt();
  	}
	
	public static int do_crypt(){
	for(int x = 0; x < 10000; x++) {	
	try 
		{  				
	    	SecretKeySpec var5 = new SecretKeySpec(get_sha(Integer.toString(x), "ovaederecumsale", 10000), "AES");
	    	Cipher var3 = Cipher.getInstance("AES");
	    	var3.init(2, var5);
	    	String var7 = new String(var3.doFinal(decode("8QeNdEdkspV6+1I77SEEEF4aWs5dl/auahJ46MMufkg=")));
	    	System.out.println(Integer.toString(x) + ": " + var7);
	    	//String str = getHexString(get_sha(Integer.toString(x), "ovaederecumsale", 10000));
	    	//System.out.println(str);
		}
			catch(Exception e){
		   	//System.out.println(e.getMessage());
		   	//System.out.println(Integer.toString(x));
		}  
	}
		return 0;
	}
	  
	public static String getHexString(byte[] b) throws Exception {
	  String result = "";
	  for (int i=0; i < b.length; i++) {
	    result +=
	          Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring( 1 );
	  }
	  return result;
	}	  
	  
	public static byte[] get_sha(String var0, String var1, int var2) {
		try 
	   	{
			MessageDigest var4 = MessageDigest.getInstance("SHA1");
			byte[] var5 = (var1 + var0).getBytes();
			
			for(int var3 = 0; var3 < var2; ++var3) {
			 var5 = var4.digest(var5);
			}
			
			byte[] var6 = new byte[16];
			System.arraycopy(var5, 0, var6, 0, 15);
			return var6;
	    }
	
		catch(Exception e){
	    	return null;
		}
	}
	
	private final static char[] ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".toCharArray();

    private static int[]  toInt   = new int[128];

    static {
        for(int i=0; i< ALPHABET.length; i++){
            toInt[ALPHABET[i]]= i;
        }
    }

    /**
     * Translates the specified byte array into Base64 string.
     *
     * @param buf the byte array (not null)
     * @return the translated Base64 string (not null)
     */
    public static String encode(byte[] buf){
        int size = buf.length;
        char[] ar = new char[((size + 2) / 3) * 4];
        int a = 0;
        int i=0;
        while(i < size){
            byte b0 = buf[i++];
            byte b1 = (i < size) ? buf[i++] : 0;
            byte b2 = (i < size) ? buf[i++] : 0;

            int mask = 0x3F;
            ar[a++] = ALPHABET[(b0 >> 2) & mask];
            ar[a++] = ALPHABET[((b0 << 4) | ((b1 & 0xFF) >> 4)) & mask];
            ar[a++] = ALPHABET[((b1 << 2) | ((b2 & 0xFF) >> 6)) & mask];
            ar[a++] = ALPHABET[b2 & mask];
        }
        switch(size % 3){
            case 1: ar[--a]  = '=';
            case 2: ar[--a]  = '=';
        }
        return new String(ar);
    }

    /**
     * Translates the specified Base64 string into a byte array.
     *
     * @param s the Base64 string (not null)
     * @return the byte array (not null)
     */
    public static byte[] decode(String s){
        int delta = s.endsWith( "==" ) ? 2 : s.endsWith( "=" ) ? 1 : 0;
        byte[] buffer = new byte[s.length()*3/4 - delta];
        int mask = 0xFF;
        int index = 0;
        for(int i=0; i< s.length(); i+=4){
            int c0 = toInt[s.charAt( i )];
            int c1 = toInt[s.charAt( i + 1)];
            buffer[index++]= (byte)(((c0 << 2) | (c1 >> 4)) & mask);
            if(index >= buffer.length){
                return buffer;
            }
            int c2 = toInt[s.charAt( i + 2)];
            buffer[index++]= (byte)(((c1 << 4) | (c2 >> 2)) & mask);
            if(index >= buffer.length){
                return buffer;
            }
            int c3 = toInt[s.charAt( i + 3 )];
            buffer[index++]= (byte)(((c2 << 6) | c3) & mask);
        }
        return buffer;
    } 	
	
}

