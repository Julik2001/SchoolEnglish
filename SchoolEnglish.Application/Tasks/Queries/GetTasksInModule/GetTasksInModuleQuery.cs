using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Tasks.Queries.GetTasksInModule
{
    public class GetTasksInModuleQuery : IRequest<ModuleTasksVm>
    {
        public Guid ModuleId { get; set; }
    }
}
