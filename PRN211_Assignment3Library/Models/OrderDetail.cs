using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class OrderDetail
{
    public int OrderDetailId { get; set; }

    public int OrderId { get; set; }

    public int ProductId { get; set; }

    public int? UnitStock { get; set; }

    public decimal? UnitPrice { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
