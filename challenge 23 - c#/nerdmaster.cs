using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Sockets;

namespace nerdmaster
{
    class Program
    {
        static void Main(string[] args)
        {

            Dictionary<string, string> insults =  new Dictionary<string, string>();

            insults.Add("You'll be 0xdeadbeef soon.", "Not as long as I have my 0xcafebabe.");
            insults.Add("Ping! Anybody there?", "ICMP type 3, code 13: Communication Administratively Prohibited");
            insults.Add("format C:", "Specified drive does not exist.");
            insults.Add("I'll check you out - any last words?", "svn:ignore");
            insults.Add("I bet you don't even understand binary.", "Sure I do. Me and you, we are 10 different kind of persons.");
            insults.Add("Go 127.0.0.1 to your mummy.", "Won't work. I only support IPv6.");
            insults.Add("Tell me your name, hobo. I need to check your records.", "My name is bob'; DROP TABLE VALJ;--");
            insults.Add("Af7ter th1s f1gh7, I w1ll pwn ur b0x3n.", "Check your settings - you seem to have chosen the Klingon keyboard layout.");
            insults.Add("Pna lbh ernq guvf?", "EBG13 vf sbe ynzref.");
            insults.Add("You're so slow, you must have been written in BASIC.", "At least I don't have memory leaks like you.");
            insults.Add("You should leave your cave and socialize a bit.", "I'm not anti-social. I'm just not user friendly.");
            insults.Add("You must be jealous when seeing my phone's display.", "Not really - Your pixels are so big, some of them have their own region code!");
            insults.Add("After loosing to me, your life won't be the same anymore.", "A Life? Cool! Where can I download one of those?");
            insults.Add("This fight is like a hash function - it works in one direction only.", "Too bad you picked LM hashing.");
            insults.Add("I have more friends than you.", "Yeah, but only until you update your Facebook profile with a real picture of you!");
            insults.Add("1f u c4n r34d th1s u r s70p1d.", "You better check your spelling. Stoopid has two 'o's.");

            byte[] data = new byte[1024];
            string input, stringData;            
            TcpClient server = new TcpClient("hackyeaster.hacking-lab.com", 1400);          // connect to the server
            NetworkStream ns = server.GetStream();
            stringData = Encoding.ASCII.GetString(data, 0, ns.Read(data, 0, data.Length));  // get server answer
            ns.Write(Encoding.ASCII.GetBytes("y\n"), 0, 2);                                 // send "y"
            stringData = Encoding.ASCII.GetString(data, 0, ns.Read(data, 0, data.Length));  // get server answer

            while (ns.CanRead)
            {
                byte[] myReadBuffer = new byte[1024];
                StringBuilder myCompleteMessage = new StringBuilder();
                int numberOfBytesRead = 0;
                do{
                    numberOfBytesRead = ns.Read(myReadBuffer, 0, myReadBuffer.Length);
                    myCompleteMessage.AppendFormat("{0}", Encoding.ASCII.GetString(myReadBuffer, 0, numberOfBytesRead));
                }while (ns.DataAvailable);
                string answer = myCompleteMessage.ToString();

                if (answer.Contains("---- YOUR TURN ----")){
                    List<string> keys = new List<string>(insults.Keys);                     // make directory to a list
                    Random rand = new Random();                                             // get a random number
                    string randomKey = keys[rand.Next(insults.Count)];                      // select a random insult

                    input = randomKey + "\n";
                    insults.Remove(randomKey);                                              // remove used insult
                    Console.WriteLine("sending: " + input);
                    ns.Write(Encoding.ASCII.GetBytes(input), 0, input.Length);

                    stringData = Encoding.ASCII.GetString(data, 0, ns.Read(data, 0, data.Length));
                    Console.WriteLine("receiving: " + stringData);
                }
                else if (answer.Contains("---- MY TURN ----")){
                    string response = answer.Replace("---- MY TURN ----", "").Replace("\n","");
                    input = insults[response]+"\n";                                         // get answer from the dictionary
                    insults.Remove(response);                                               // remove it, to stay unique
                    Console.WriteLine("sending: " + input);
                    ns.Write(Encoding.ASCII.GetBytes(input), 0, input.Length);
                }
                else if (answer.Contains("You loose!")){
                    Console.WriteLine(answer);
                    return;
                }
                else if (answer.Contains("Respect!")){
                    Console.WriteLine(answer);
                    Console.ReadLine();
                    return;
                }
            }
        }
    }
}
