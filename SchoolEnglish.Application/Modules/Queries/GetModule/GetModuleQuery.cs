using MediatR;

namespace SchoolEnglish.Application.Modules.Queries.GetModule
{
    public class GetModuleQuery : IRequest<ModuleDto>
    {
        public Guid ModuleId { get; set; }
    }
}
