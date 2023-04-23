using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolEnglish.Domain
{
    public class Task
    {
        public Guid Id { get; set; }
        public string Header { get; set; }
        public int Reward { get; set; }
    }
}
