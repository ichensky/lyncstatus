using LyncStatus;
using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncBot
{
    class Program
    {
        static void Main(string[] args)
        {
            //args = new string[] { "-c", "-cs", "--json" };

            var initData = new InitData();
            var statusCode = initData.Init(args);
            var flags = initData.Flags;

            var exitManager = new ExitManager();
            if (statusCode == -1)
            {
                exitManager.Error(); 
                return;
            }

            if (flags.Help == 1 || statusCode == 1)
            {
                exitManager.Help();  
                return;
            }

            var lyncClient = LyncClient.GetClient();
            if (lyncClient.State == ClientState.SignedIn)
            {
                exitManager = new ExitManager(lyncClient, initData);
                if (flags.Status == 1 || flags.Note == 1)
                {
                    exitManager.Status();
                }
                else if (flags.Contacts == 1)
                {
                    exitManager.Contacts().Wait();                    
                }
                else if (flags.ContactStatus == 1)
                {
                    exitManager.CurrentContactStatus();
                }
            }

            return;
        }
    }
}
