using MediatR;

namespace SchoolEnglish.Application.Tasks.Queries.GetTasksInModule
{
    public class GetTasksInModuleQuery : IRequest<ModuleTasksVm>
    {
        public Guid ModuleId { get; set; }
    }
}
