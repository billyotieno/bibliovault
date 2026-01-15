-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "username" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(100),
    "last_name" VARCHAR(100),
    "role" VARCHAR(50) NOT NULL DEFAULT 'user',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_login" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "authors" (
    "author_id" SERIAL NOT NULL,
    "first_name" VARCHAR(200),
    "last_name" VARCHAR(200),
    "full_name" VARCHAR(400) NOT NULL,
    "bio" TEXT,
    "birth_date" DATE,
    "nationality" VARCHAR(100),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "authors_pkey" PRIMARY KEY ("author_id")
);

-- CreateTable
CREATE TABLE "genres" (
    "genre_id" SERIAL NOT NULL,
    "genre_name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "parent_genre_id" INTEGER,

    CONSTRAINT "genres_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "tags" (
    "tag_id" SERIAL NOT NULL,
    "tag_name" VARCHAR(100) NOT NULL,
    "color" VARCHAR(7),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("tag_id")
);

-- CreateTable
CREATE TABLE "books" (
    "book_id" SERIAL NOT NULL,
    "isbn" VARCHAR(13),
    "title" VARCHAR(500) NOT NULL,
    "subtitle" VARCHAR(500),
    "publisher" VARCHAR(200),
    "publication_date" DATE,
    "edition" VARCHAR(100),
    "language" VARCHAR(50),
    "pages" INTEGER,
    "description" TEXT,
    "cover_image_url" VARCHAR(500),
    "physical_location" VARCHAR(200),
    "purchase_date" DATE,
    "purchase_price" DECIMAL(10,2),
    "condition" VARCHAR(50),
    "status" VARCHAR(50) NOT NULL DEFAULT 'available',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "books_pkey" PRIMARY KEY ("book_id")
);

-- CreateTable
CREATE TABLE "book_authors" (
    "book_id" INTEGER NOT NULL,
    "author_id" INTEGER NOT NULL,
    "author_order" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "book_authors_pkey" PRIMARY KEY ("book_id","author_id")
);

-- CreateTable
CREATE TABLE "book_genres" (
    "book_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "book_genres_pkey" PRIMARY KEY ("book_id","genre_id")
);

-- CreateTable
CREATE TABLE "book_tags" (
    "book_id" INTEGER NOT NULL,
    "tag_id" INTEGER NOT NULL,

    CONSTRAINT "book_tags_pkey" PRIMARY KEY ("book_id","tag_id")
);

-- CreateTable
CREATE TABLE "reading_sessions" (
    "session_id" SERIAL NOT NULL,
    "book_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    "start_page" INTEGER,
    "end_page" INTEGER,
    "current_page" INTEGER,
    "status" VARCHAR(50) NOT NULL DEFAULT 'reading',
    "rating" DECIMAL(3,2),
    "review" TEXT,
    "notes" TEXT,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reading_sessions_pkey" PRIMARY KEY ("session_id")
);

-- CreateTable
CREATE TABLE "borrowers" (
    "borrower_id" SERIAL NOT NULL,
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255),
    "phone" VARCHAR(20),
    "address" TEXT,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "borrowers_pkey" PRIMARY KEY ("borrower_id")
);

-- CreateTable
CREATE TABLE "borrowing_transactions" (
    "transaction_id" SERIAL NOT NULL,
    "book_id" INTEGER NOT NULL,
    "borrower_id" INTEGER NOT NULL,
    "borrowed_date" DATE NOT NULL,
    "due_date" DATE NOT NULL,
    "return_date" DATE,
    "status" VARCHAR(50) NOT NULL DEFAULT 'borrowed',
    "notes" TEXT,
    "reminder_sent" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "borrowing_transactions_pkey" PRIMARY KEY ("transaction_id")
);

-- CreateTable
CREATE TABLE "reading_goals" (
    "goal_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "target_books" INTEGER,
    "target_pages" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reading_goals_pkey" PRIMARY KEY ("goal_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "genres_genre_name_key" ON "genres"("genre_name");

-- CreateIndex
CREATE UNIQUE INDEX "tags_tag_name_key" ON "tags"("tag_name");

-- CreateIndex
CREATE UNIQUE INDEX "books_isbn_key" ON "books"("isbn");

-- CreateIndex
CREATE UNIQUE INDEX "borrowers_email_key" ON "borrowers"("email");

-- AddForeignKey
ALTER TABLE "genres" ADD CONSTRAINT "genres_parent_genre_id_fkey" FOREIGN KEY ("parent_genre_id") REFERENCES "genres"("genre_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_authors" ADD CONSTRAINT "book_authors_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_authors" ADD CONSTRAINT "book_authors_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("author_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_genres" ADD CONSTRAINT "book_genres_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_genres" ADD CONSTRAINT "book_genres_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "genres"("genre_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_tags" ADD CONSTRAINT "book_tags_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_tags" ADD CONSTRAINT "book_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("tag_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reading_sessions" ADD CONSTRAINT "reading_sessions_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reading_sessions" ADD CONSTRAINT "reading_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "borrowing_transactions" ADD CONSTRAINT "borrowing_transactions_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "borrowing_transactions" ADD CONSTRAINT "borrowing_transactions_borrower_id_fkey" FOREIGN KEY ("borrower_id") REFERENCES "borrowers"("borrower_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reading_goals" ADD CONSTRAINT "reading_goals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
