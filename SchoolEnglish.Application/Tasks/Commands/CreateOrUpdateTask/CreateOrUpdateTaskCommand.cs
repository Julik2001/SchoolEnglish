using MediatR;

namespace SchoolEnglish.Application.Tasks.Commands.CreateOrUpdateTask
{
    public class CreateOrUpdateTaskCommand : IRequest<Guid>
    {
        public Guid? Id { get; set; }
        public string Header { get; set; }
        public int TimeInMinutes { get; set; }
        public int Reward { get; set; }
        public Guid ModuleId { get; set; }
    }
}
