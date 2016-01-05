using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncLib.Helpers
{
    public class ContactHelper
    {

        public ContactAvailability GetContactAvailability(Contact contact)
        {
            var status = contact.GetContactInformation(ContactInformationType.Availability).Cast<ContactAvailability>();
            return status;
        }

    }
}
