using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class Category
{
    public int CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public int? Status { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
