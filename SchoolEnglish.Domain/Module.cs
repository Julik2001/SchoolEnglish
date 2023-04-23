using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolEnglish.Domain
{
    public class Module
    {
        public Guid Id { get; set; }
        public string? Number { get; set; }
        public string Name { get; set; }
        public Guid? ParentId { get; set; }
        public Module? Parent { get; set; }
    }
}
