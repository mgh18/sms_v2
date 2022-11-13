using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMS.Models
{
    public class GetStatModel
    {
            public string Name { get; set; }
            public int invited_students { get; set; }
            public int accepted { get; set; }
            public double Percentage { get; set; }
            public double weighted_avg { get; set; }
            public int weighted { get; set; }

        public string Percentage_s
        {
            get
            {
                return string.Format("{0} %", Percentage);
            }
        }


    }
}