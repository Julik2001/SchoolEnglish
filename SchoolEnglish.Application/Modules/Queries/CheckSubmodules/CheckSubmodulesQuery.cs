using MediatR;

namespace SchoolEnglish.Application.Modules.Queries.CheckSubmodules
{
    public class CheckSubmodulesQuery : IRequest<bool>
    {
        public Guid ModuleId { get; set; }
    }
}
