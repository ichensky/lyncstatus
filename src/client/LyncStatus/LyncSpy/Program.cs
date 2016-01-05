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

        static void Main(string[] args)
        {
            var _lyncClient = LyncClient.GetClient();
            
            if (_lyncClient.State == ClientState.SignedIn)
            {
                var t = Task.Factory.StartNew(() =>
                {
                    var contactsManager = new ContactsManager(_lyncClient);
                    contactsManager.AllContactsLoaded += contactsManager_AllContactsLoaded;
                    contactsManager.GetAllContacts();
                    AllContactsLoaded.WaitOne();
                });
            }
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

            //var str = Newtonsoft.Json.JsonConvert.SerializeObject(contacts);
            //Console.WriteLine(str);
          
            AllContactsLoaded.Set();
        }

    }
}
