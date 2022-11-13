[assembly: WebActivatorEx.PreApplicationStartMethod(typeof(SMS.App_Start.NinjectWebCommon), "Start")]
[assembly: WebActivatorEx.ApplicationShutdownMethodAttribute(typeof(SMS.App_Start.NinjectWebCommon), "Stop")]

namespace SMS.App_Start
{
    using System;
    using System.Web;
    using DataLayer.Repositories;
    using DataLayer.Services;
    using Microsoft.Web.Infrastructure.DynamicModuleHelper;

    using Ninject;
    using Ninject.Web.Common;
    using Ninject.Web.Common.WebHost;

    public static class NinjectWebCommon 
    {
        private static readonly Bootstrapper bootstrapper = new Bootstrapper();

        /// <summary>
        /// Starts the application.
        /// </summary>
        public static void Start() 
        {
            DynamicModuleUtility.RegisterModule(typeof(OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof(NinjectHttpModule));
            bootstrapper.Initialize(CreateKernel);
        }

        /// <summary>
        /// Stops the application.
        /// </summary>
        public static void Stop()
        {
            bootstrapper.ShutDown();
        }

        /// <summary>
        /// Creates the kernel that will manage your application.
        /// </summary>
        /// <returns>The created kernel.</returns>
        private static IKernel CreateKernel()
        {
            var kernel = new StandardKernel();
            try
            {
                kernel.Bind<Func<IKernel>>().ToMethod(ctx => () => new Bootstrapper().Kernel);
                kernel.Bind<IHttpModule>().To<HttpApplicationInitializationHttpModule>();
                
                kernel.Bind<IAccountRepository>().To<AccountRepository>();
                kernel.Bind<ICourseRepository>().To<CourseRepository>();
                kernel.Bind<IHoursRepository>().To<HoursRepository>();
                kernel.Bind<IInvitationRepository>().To<InvitationRepository>();
                kernel.Bind<IMenuItemRepository>().To<MenuItemRepository>();
                kernel.Bind<INameOfCourseRepository>().To<NameOfCourseRepository>();
                kernel.Bind<IRoleMenuRepository>().To<RoleMenuRepository>();
                kernel.Bind<IRoleRepository>().To<RoleRepository>();
                kernel.Bind<IStudentRepository>().To<StudentRepository>();
                kernel.Bind<ITeacherRepository>().To<TeacherRepository>();
                kernel.Bind<ITeachRepository>().To<TeachRepository>();
                kernel.Bind<IWeekdaysRepository>().To<WeekdaysRepository>();
               
                RegisterServices(kernel);
                return kernel;
            }
            catch
            {
                kernel.Dispose();
                throw;
            }
        }

        /// <summary>
        /// Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel)
        {
        }
    }
}