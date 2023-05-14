using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.UserAnswers.Commands.CreateOrUpdateUserAnswer;
using SchoolEnglish.WebApi.Models;
using System.Security.Claims;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class UserAnswersController : BaseController
    {
        private readonly IMapper _mapper;

        public UserAnswersController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Guid>> CreateOrUpdate([FromBody] CreateOrUpdateUserAnswerDto createOrUpdateUserAnswerDto)
        {
            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }

            var command = _mapper.Map<CreateOrUpdateUserAnswerCommand>(createOrUpdateUserAnswerDto);
            command.UserId = Guid.Parse(userIdClaim.Value);
            
            var asnwerId = await Mediator.Send(command);
            return Ok(asnwerId);
        }
    }
}
