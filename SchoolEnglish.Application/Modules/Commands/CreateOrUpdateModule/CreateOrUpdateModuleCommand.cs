using MediatR;

namespace SchoolEnglish.Application.Modules.Commands.CreateOrUpdateModule
{
    public class CreateOrUpdateModuleCommand : IRequest<Guid>
    {
        public Guid? Id { get; set; }
        public string? Number { get; set; }
        public string Name { get; set; }
        public Guid? ParentId { get; set; }
    }
}
