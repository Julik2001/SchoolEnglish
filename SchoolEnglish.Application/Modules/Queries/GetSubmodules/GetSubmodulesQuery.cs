using MediatR;

namespace SchoolEnglish.Application.Modules.Queries.GetSubmodules
{
    public class GetSubmodulesQuery : IRequest<SubmodulesVm>
    {
        public Guid ModuleId { get; set; }
    }
}
