using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using SchoolEnglish.Application.TaskParts.Commands.CreateOrUpdateTaskPart;
using SchoolEnglish.Application.TaskParts.Commands.DeleteTaskPart;
using SchoolEnglish.Application.TaskParts.Queries;
using SchoolEnglish.Application.TaskParts.Queries.GetTaskPartsInTask;
using SchoolEnglish.Application.TaskParts.Queries.GetTaskPartWithContent;
using SchoolEnglish.Application.TaskPartsContent.Commands.CreateOrUpdateTaskPartContent;
using SchoolEnglish.WebApi.Models;
using SchoolEnglish.WebApi.Options;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class TaskPartController : BaseController
    {
        private readonly IMapper _mapper;
        private readonly TaskPartContentOptions _options;

        public TaskPartController(IMapper mapper, IOptions<TaskPartContentOptions> options)
        {
            _mapper = mapper;
            _options = options.Value;
        }

        [Authorize]
        [HttpGet("{taskId}")]
        public async Task<ActionResult<TaskPartsVm>> GetTaskParts(Guid taskId)
        {
            var query = new GetTaskPartsInTaskQuery { TaskId = taskId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpGet("{taskPartId}")]
        public async Task<ActionResult<TaskPartVm>> GetTaskPartWithContent(Guid taskPartId)
        {
            var query = new GetTaskPartWithContentQuery { Id = taskPartId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Guid>> CreateOrUpdate([FromForm] CreateOrUpdateTaskPartDto createOrUpdateTaskPartDto)
        {
            var command = _mapper.Map<CreateOrUpdateTaskPartCommand>(createOrUpdateTaskPartDto);
            var taskPartId = await Mediator.Send(command);

            string? imagePath = null;
            if (createOrUpdateTaskPartDto.ImageFile != null && createOrUpdateTaskPartDto.ImageFile.Length > 0)
            {
                imagePath = $"{DateTime.Now.ToString("dd-MM-yyyy_HH-mm")} {createOrUpdateTaskPartDto.ImageFile.FileName}";
                var filePath = Path.Combine(_options.ImageFolder, imagePath);
                Directory.CreateDirectory(_options.ImageFolder);
                using (var stream = System.IO.File.Create(filePath))
                {
                    await createOrUpdateTaskPartDto.ImageFile.CopyToAsync(stream);
                }
            }

            string? audioPath = null;
            if (createOrUpdateTaskPartDto.AudioFile != null && createOrUpdateTaskPartDto.AudioFile.Length > 0)
            {
                audioPath = $"{DateTime.Now.ToString("dd-MM-yyyy_HH-mm")} {createOrUpdateTaskPartDto.AudioFile.FileName}";
                var filePath = Path.Combine(_options.AudioFolder, audioPath);
                Directory.CreateDirectory(_options.AudioFolder);
                using (var stream = System.IO.File.Create(filePath))
                {
                    await createOrUpdateTaskPartDto.AudioFile.CopyToAsync(stream);
                }
            }

            var contentCommand = new CreateOrUpdateTaskPartContentCommand
            {
                Text = createOrUpdateTaskPartDto.Text,
                TextToRead = createOrUpdateTaskPartDto.TextToRead,
                AnswerVariants = createOrUpdateTaskPartDto.AnswerVariants,
                ImagePath = imagePath,
                AudioPath = audioPath,
                TypeId = createOrUpdateTaskPartDto.TypeId,
                TaskPartId = taskPartId
            };
            await Mediator.Send(contentCommand);

            return Ok(taskPartId);
        }

        [Authorize]
        [HttpDelete("{taskPartId}")]
        public async Task<IActionResult> Delete(Guid taskPartId)
        {
            var command = new DeleteTaskPartCommand { Id = taskPartId };
            await Mediator.Send(command);
            return Ok();
        }
    }
}
