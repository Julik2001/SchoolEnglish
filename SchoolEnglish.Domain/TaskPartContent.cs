using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolEnglish.Domain
{
    public class TaskPartContent
    {
        public Guid Id { get; set; }
        public string? Text { get; set; }
        public string? ImagePath { get; set; }
        public string? AudioPath { get; set; }
        public Guid TypeId { get; set; }
        public TaskPartContentType Type { get; set; }
    }
}
