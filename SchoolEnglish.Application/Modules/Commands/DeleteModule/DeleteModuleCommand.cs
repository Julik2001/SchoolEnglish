using MediatR;

namespace SchoolEnglish.Application.Modules.Commands.DeleteModule
{
    public class DeleteModuleCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
