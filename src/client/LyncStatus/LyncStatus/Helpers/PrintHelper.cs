using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncStatus.Helpers
{
    public class PrintHelper
    {
        public void Print()
        {
            Console.WriteLine("-h, --help");
            Console.WriteLine(@"         Show this help.");
            Console.WriteLine("-c, --contacts {-cs, -j}");
            Console.WriteLine(@"         Show list of contacts.");
            Console.WriteLine("-cs, --contactstatus");
            Console.WriteLine(@"         Show contact status.");
            Console.WriteLine("--json");
            Console.WriteLine(@"         Show output in json format.");
            Console.WriteLine("\n-s, --status {status}");
            Console.WriteLine(@"
         Free: the contact is available.
         FreeIdle: idle states are machine state.        
         Busy: the contact is busy and inactive.        
         BusyIdle: idle states are machine state.        
         DoNotDisturb: the contact does not want to be disturbed.        
         TemporarilyAway: the contact is temporarily un-alertable.        
         Away: the contact cannot be alerted.        
         Offline: the contact is not available.");
            Console.WriteLine("\n-n, --note {note}");
            Console.WriteLine(@"         User status note.");
        }
    }
}
