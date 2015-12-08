using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncLib.Models
{
    public class Contact
    {
        public string Uri { get; set; }
        public ContactAvailability Status { get; set; }
    }
}
