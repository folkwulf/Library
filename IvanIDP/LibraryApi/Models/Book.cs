using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LibraryApi.Models
{
	public class Book
    {
		[Key]
		[Column(TypeName = "int")]
		public long BookId { get; set; }

		[Column(TypeName = "varchar(20)")]
		public string Isbn { get; set; }

		[Column(TypeName = "varchar(50)")]
		public string Title { get; set; }

		[Column(TypeName = "varchar(1000)")]
		public string BriefDescription { get; set; }

		[Column(TypeName = "tinyint")]
		public int GenreId { get; set; }

		[Column(TypeName = "varchar(200)")]
		public string Author { get; set; }

		[Column(TypeName = "tinyint")]
		public int BookConditionId { get; set; }

		[Column(TypeName = "varchar(1000)")]
		public string Comment { get; set; }

		[Column(TypeName = "Date")]
		public DateTime RegistrationDate { get; set; }

	}
}
