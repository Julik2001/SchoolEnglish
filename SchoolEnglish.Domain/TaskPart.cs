using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolEnglish.Domain
{
    public class TaskPart
    {
        public Guid Id { get; set; }
        public string Number { get; set; }
        public string RightAnswer { get; set; }
        public string ClueText { get; set; }
        public string ClueCost { get; set; }
        public Guid TaskId { get; set; }
        public Task Task { get; set; }
    }
}
