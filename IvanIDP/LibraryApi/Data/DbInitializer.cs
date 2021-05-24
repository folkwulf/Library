using LibraryApi.Models;
using System;
using System.Linq;

namespace LibraryApi.Data
{
    public class DbInitializer
    {
        public static void Initialize(LibraryContext context)
        {
            if (context.Books.Any())
            {
                return;
            }

            var books = new Book[]
            {
                new Book{ Isbn = "978-1-940313-09-1", Title = "Title1", BriefDescription = "Description1", GenreId = 1, Author = "Author1", BookConditionId = 1, Comment = "Comment1", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-2", Title = "Title2", BriefDescription = "Description2", GenreId = 1, Author = "Author2", BookConditionId = 1, Comment = "Comment2", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-3", Title = "Title3", BriefDescription = "Description3", GenreId = 1, Author = "Author3", BookConditionId = 1, Comment = "Comment3", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-4", Title = "Title4", BriefDescription = "Description4", GenreId = 1, Author = "Author4", BookConditionId = 1, Comment = "Comment4", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-5", Title = "Title5", BriefDescription = "Description5", GenreId = 1, Author = "Author5", BookConditionId = 1, Comment = "Comment5", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-6", Title = "Title6", BriefDescription = "Description6", GenreId = 1, Author = "Author6", BookConditionId = 1, Comment = "Comment6", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-7", Title = "Title7", BriefDescription = "Description7", GenreId = 1, Author = "Author7", BookConditionId = 1, Comment = "Comment7", RegistrationDate = new DateTime(2021,01,01) },
                new Book{ Isbn = "978-1-940313-09-8", Title = "Title8", BriefDescription = "Description8", GenreId = 1, Author = "Author8", BookConditionId = 1, Comment = "Comment8", RegistrationDate = new DateTime(2021,01,01) }
            };

            context.Books.AddRange(books);
            context.SaveChanges();
        }
    }
}
