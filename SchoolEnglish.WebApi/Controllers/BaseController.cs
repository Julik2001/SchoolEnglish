﻿using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public abstract class BaseController : ControllerBase
    {
        private IMediator _mediator;
        protected IMediator Mediator =>
            _mediator ?? (_mediator = HttpContext.RequestServices.GetService<IMediator>());
    }
}
