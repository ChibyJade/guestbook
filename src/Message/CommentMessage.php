<?php

namespace App\Message;

class CommentMessage
{
    private $id;
    private $reviewUrl;
    private $context;
    private $email;

    public function __construct(int $id, string $reviewUrl, array $context = [], string $email = "")
    {
        $this->id = $id;
        $this->reviewUrl = $reviewUrl;
        $this->context = $context;
        $this->email = $email;
    }

    public function getReviewUrl(): string
    {
        return $this->reviewUrl;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getContext(): array
    {
        return $this->context;
    }

    public function getEmail(): array
    {
        return $this->email;
    }
}
