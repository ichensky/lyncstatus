using LyncLib.Models;
using Microsoft.Lync.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LyncStatus
{
    public class InitDataFlags
    {
        public int Help { get; set; }
        public int Contacts { get; set; }
        public int Status { get; set; }
        public int Note { get; set; }
        public int ContactStatus { get; set; }
        public PrintFormat Format { get; set; }
    }

    public class InitData
    {
        public InitDataFlags Flags { get; set; }

        public ContactAvailability Status { get; set; }
        public string Note { get; set; }

        public int Init(string[] args)
        {
            if (args == null)
            {
                return (-1);
            }

            var flags = this.Flags = new InitDataFlags();

            try
            {
                for (int i = 0; i < args.Length; i++)
                {
                    var item = args[i].ToLower();
                    if (item == "--help" || item == "-h")
                    {
                        flags.Help = 1;
                        return (0);
                    }
                    if (item == "--contacts" || item == "-c")
                    {
                        flags.Contacts = 1;
                        continue;
                    }
                    if (item == "--contactstatus" || item == "-cs")
                    {
                        flags.ContactStatus = 1;
                        continue;
                    }
                    if (item == "--json")
                    {
                        flags.Format = PrintFormat.Json;
                        continue;
                    }

                    if (item == "--status" || item == "-s")
                    {
                        flags.Status = 1;
                        ContactAvailability status;
                        var flag = Enum.TryParse(args[i + 1], out status);

                        if (!flag)
                        {
                            return (-1);
                        }
                        this.Status = status;
                        continue;
                    }
                    if (item == "--note" || item == "-n")
                    {
                        flags.Note = 1;
                        this.Note = args[i + 1];
                        continue;
                    }

                }
            }
            catch (Exception)
            {
                return (-1);
            }

            return (0);
        }
    }
}
