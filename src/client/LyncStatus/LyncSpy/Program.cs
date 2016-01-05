using LyncLib;
using LyncLib.Helpers;
using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LyncSpy
{
    class Program
    {
        private LyncClient _lyncClient;
        private static ManualResetEvent AllContactsLoaded = new ManualResetEvent(false);
        //private Queue<contacts_for_db>

        static void Main(string[] args)
        {
            label:
            var _lyncClient = LyncClient.GetClient();
            
            if (_lyncClient.State == ClientState.SignedIn)
            {
                var contactsManager = new ContactsManager(_lyncClient);
            }
            else
            {
                Console.WriteLine("Lync client isn't signed in, trying again..");
                Thread.Sleep(100);
                goto label;
            }
            
            Console.ReadLine();
        }

        static void func(ContactsManager contactsManager)
        {
            var t = Task.Factory.StartNew(() =>
            {
                contactsManager.AllContactsLoaded += contactsManager_AllContactsLoaded;
                contactsManager.GetAllContacts();
                AllContactsLoaded.WaitOne();
                Thread.Sleep(100);
            }).ContinueWith(x => func(contactsManager));
        }

        static void contactsManager_AllContactsLoaded(object sender, List<Contact> e)
        {
            var contactHelper = new ContactHelper();
            var contacts = new List<LyncLib.Models.ContactState>();
            foreach (var item in e)
            {
                contacts.Add(new LyncLib.Models.ContactState()
                {
                    Status = contactHelper.GetContactAvailability(item),
                    Uri = item.Uri,
                });
            }

            // Queue<contacts_for_db>.push(new object_contact)



            //var str = Newtonsoft.Json.JsonConvert.SerializeObject(contacts);
            //Console.WriteLine(str);
          
            AllContactsLoaded.Set();
        }

    }
}
