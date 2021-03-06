﻿using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using LyncStatus.Helpers;
using LyncLib;
using LyncLib.Helpers;

namespace LyncStatus
{
    public class ExitManager
    {
        private LyncClient _lyncClient;
        private InitData _initData;
        private ManualResetEvent AllContactsLoaded = new ManualResetEvent(false);

        public ExitManager()
        {

        }

        public ExitManager(LyncClient lyncClient, InitData initData)
        {
            _lyncClient = lyncClient;
            _initData = initData;
        }

        public Task Contacts()
        {
            return Task.Factory.StartNew(() => {
                var contactsManager = new ContactsManager(_lyncClient);
                contactsManager.AllContactsLoaded += contactsManager_AllContactsLoaded;
                contactsManager.GetAllContacts();
                AllContactsLoaded.WaitOne();
            });
        }
        
        void contactsManager_AllContactsLoaded(object sender, List<Contact> e)
        {
            var flags = _initData.Flags;
            var contactHelper = new ContactHelper();
            var contacts = new List<LyncLib.Models.ContactState> ();
            foreach (var item in e)
            {
                contacts.Add(new LyncLib.Models.ContactState()
                {
                    Status = flags.ContactStatus == 1 
                    ? contactHelper.GetContactAvailability(item) 
                    : ContactAvailability.Invalid,
                    Uri = item.Uri,
                });

            }

            if (flags.Format == LyncLib.Models.PrintFormat.Json)
            {
                var str = Newtonsoft.Json.JsonConvert.SerializeObject(contacts);
                Console.WriteLine(str);
            }
            else
            {
                var str = "{0,-25}" + (flags.ContactStatus == 1 ? "{1,25}" : "");
                foreach (var contact in contacts)
                {
                    Console.WriteLine(str, contact.Uri, contact.Status.ToString()); 
                }
            }

            AllContactsLoaded.Set();
        }

        public void Status()
        {
            var flags = _initData.Flags;
            var dict = new Dictionary<PublishableContactInformationType, object>();
            if (flags.Status == 1)
            {
                dict.Add(PublishableContactInformationType.Availability, _initData.Status);
            }
            if (flags.Note == 1)
            {
                dict.Add(PublishableContactInformationType.PersonalNote, _initData.Note);
            }

            _lyncClient.Self.BeginPublishContactInformation(dict, null, null);
        }

        public void CurrentContactStatus()
        {
            var contact = _lyncClient.Self.Contact;
            var flags = _initData.Flags;
            if (flags.ContactStatus == 1)
            {
                var contactHelper = new ContactHelper();
                Console.WriteLine(contactHelper.GetContactAvailability(contact).ToString());                
            }
        }

        public void Error()
        {
            Console.WriteLine("Check input data. use `-h` flag to see help.");
        }

        public void Help()
        {
            new PrintHelper().Print();
        }

    }
}
