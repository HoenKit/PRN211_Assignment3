﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN211_Assignment3Library.Models;
using PRN211_Assignment3Web.Models;
using System.Diagnostics;
using System.Text;

namespace PRN211_Assignment3Web.Controllers
{
    public class HomeController : BaseController
    {
        private readonly ILogger<HomeController> _logger;
        private readonly Prn211Assignment3Context _context;

        public HomeController(ILogger<HomeController> logger, Prn211Assignment3Context context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<IActionResult> Index(string? name)
        {
            var products = await _context.Products.Include(p => p.Category).Include(p => p.User).ToListAsync();
            if (name != null)
            {
                return View(products.Where(p => p.ProductName
                    .Contains(name, StringComparison.OrdinalIgnoreCase)));
            }
            return View(products);
        }


        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Category)
                .Include(p => p.User)
                .FirstOrDefaultAsync(m => m.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }
    }
}
