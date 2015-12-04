using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncStatus
{
    public class ContactsManager
    {
        private static char[] Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();

        private LyncClient _lyncClient;

        public event EventHandler<List<Contact>> AllContactsLoaded;

        public ContactsManager(LyncClient lyncClient)
        {
            _lyncClient = lyncClient;
        }

        public void GetAllContacts()
        {
            int initialLetterIndex = 0;

            _lyncClient.ContactManager.BeginSearch(
              Alphabet[initialLetterIndex].ToString(),
              SearchProviders.GlobalAddressList,
              SearchFields.FirstName,
              SearchOptions.ContactsOnly,
              300,
              SearchAllCallback,
              new object[] { initialLetterIndex, new List<Contact>() }
            );
        }

        private void SearchAllCallback(IAsyncResult result)
        {
            var parameters = (object[])result.AsyncState;
            var letterIndex = (int)parameters[0] + 1;
            var contacts = (List<Contact>)parameters[1];

            var results = _lyncClient.ContactManager.EndSearch(result);
            contacts.AddRange(results.Contacts);

            if (letterIndex < Alphabet.Length)
            {
                _lyncClient.ContactManager.BeginSearch(
                  Alphabet[letterIndex].ToString(),
                  SearchAllCallback,
                  new object[] { letterIndex, contacts }
                );
            }
            else
            {
                if (AllContactsLoaded != null)
                {
                    AllContactsLoaded(this, contacts);
                }
            }
        }
    }
}
