using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeTextIsMultiline
{
    public class CheckContentTypeTextIsMultilineHandler : IRequestHandler<CheckContentTypeTextIsMultilineQuery, bool>
    {
        public async Task<bool> Handle(CheckContentTypeTextIsMultilineQuery request, CancellationToken cancellationToken)
        {
            return BaseTaskPartContentTypesHelper.GetTypesWithMultilineText().Any(type => type.Id == request.TypeId);
        }
    }
}
