using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasImage
{
    public class CheckContentTypeHasImageHandler : IRequestHandler<CheckContentTypeHasImageQuery, bool>
    {
        public async Task<bool> Handle(CheckContentTypeHasImageQuery request, CancellationToken cancellationToken)
        {
            return BaseTaskPartContentTypesHelper.GetTypesWithImage().Any(type => type.Id == request.TypeId);
        }
    }
}
