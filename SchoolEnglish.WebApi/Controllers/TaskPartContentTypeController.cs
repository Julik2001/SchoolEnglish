using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAnswerVariants;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAudio;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasImage;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasTextToRead;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeTextIsMultiline;
using SchoolEnglish.Application.TaskPartsContentTypes.Queries.GetContentTypes;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class TaskPartContentTypeController : BaseController
    {
        private readonly IMapper _mapper;

        public TaskPartContentTypeController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<TaskPartContentTypesVm>> GetTypes()
        {
            var query = new GetContentTypesQuery();
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpGet("{typeId}")]
        public async Task<ActionResult<bool>> CheckTypeHasMultilineText(Guid typeId)
        {
            var query = new CheckContentTypeTextIsMultilineQuery { TypeId = typeId };
            var result = await Mediator.Send(query);
            return Ok(result);
        }

        [Authorize]
        [HttpGet("{typeId}")]
        public async Task<ActionResult<bool>> CheckTypeHasTextToRead(Guid typeId)
        {
            var query = new CheckContentTypeHasTextToReadQuery { TypeId = typeId };
            var result = await Mediator.Send(query);
            return Ok(result);
        }

        [Authorize]
        [HttpGet("{typeId}")]
        public async Task<ActionResult<bool>> CheckTypeHasAnswerVariants(Guid typeId)
        {
            var query = new CheckContentTypeHasAnswerVariantsQuery { TypeId = typeId };
            var result = await Mediator.Send(query);
            return Ok(result);
        }

        [Authorize]
        [HttpGet("{typeId}")]
        public async Task<ActionResult<bool>> CheckTypeHasImage(Guid typeId)
        {
            var query = new CheckContentTypeHasImageQuery { TypeId = typeId };
            var result = await Mediator.Send(query);
            return Ok(result);
        }

        [Authorize]
        [HttpGet("{typeId}")]
        public async Task<ActionResult<bool>> CheckTypeHasAudio(Guid typeId)
        {
            var query = new CheckContentTypeHasAudioQuery { TypeId = typeId };
            var result = await Mediator.Send(query);
            return Ok(result);
        }
    }
}
