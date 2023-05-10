using MediatR;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasImage
{
    public class CheckContentTypeHasImageQuery : IRequest<bool>
    {
        public Guid TypeId { get; set; }
    }
}
