//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataLayer.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class RoleMenu
    {
        public int Sysid { get; set; }
        public int RoleId { get; set; }
        public int MenuId { get; set; }
        public int CreatedBy { get; set; }
    
        public virtual MenuItem MenuItem { get; set; }
        public virtual Role Role { get; set; }
    }
}
