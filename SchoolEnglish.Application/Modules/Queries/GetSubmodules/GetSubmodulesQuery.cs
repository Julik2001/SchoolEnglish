using MediatR;
using SchoolEnglish.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolEnglish.Application.Modules.Queries.GetSubmodules
{
    public class GetSubmodulesQuery : IRequest<SubmodulesVm>
    {
        public Guid ParentId { get; set; }
    }
}
