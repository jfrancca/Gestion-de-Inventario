<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Categorie;

class CategorieController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:255|unique:categories,name',
            'description' => 'nullable|string',
        ]);

        $category = Categorie::create($validated);

        return response()->json([
            'message'  => 'Categoría creada con éxito.',
            'category' => $category,
        ], 201);
    }
}
