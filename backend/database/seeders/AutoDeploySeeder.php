<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Profile;
use App\Models\Skill;
use App\Models\Project;
use App\Models\Certification;
use App\Models\TimelineEvent;
use App\Models\Stat;

class AutoDeploySeeder extends Seeder
{
    public function run(): void
    {
        // Create admin user if not exists
        if (!User::where('email', 'admin@example.com')->exists()) {
            User::create([
                'name' => 'Admin',
                'email' => 'admin@example.com',
                'password' => bcrypt('password123'), // Change this!
            ]);
            $this->command->info('✅ Admin user created: admin@example.com / password123');
        }

        // Create profile if not exists
        if (!Profile::exists()) {
            Profile::create([
                'name' => 'Il Tuo Nome',
                'title' => 'Full Stack Developer',
                'bio' => 'Sono un developer appassionato di tecnologia e innovazione.',
                'email' => 'tuoemail@example.com',
                // Only include fields that exist in the migration
            ]);
            $this->command->info('✅ Profile created');
        }

        // Create sample skills
        if (Skill::count() < 3) {
            $skills = [
                ['name' => 'PHP', 'level' => 90, 'category' => 'Backend'],
                ['name' => 'Laravel', 'level' => 85, 'category' => 'Backend'],
                ['name' => 'JavaScript', 'level' => 88, 'category' => 'Frontend'],
                ['name' => 'React', 'level' => 80, 'category' => 'Frontend'],
                ['name' => 'Next.js', 'level' => 75, 'category' => 'Frontend'],
                ['name' => 'Docker', 'level' => 70, 'category' => 'DevOps'],
            ];

            foreach ($skills as $skill) {
                Skill::firstOrCreate(['name' => $skill['name']], $skill);
            }
            $this->command->info('✅ Skills created');
        }

        // Create sample projects
        if (Project::count() < 2) {
            $projects = [
                [
                    'title' => 'Tech Portfolio',
                    'description' => 'Portfolio personale con Laravel e Next.js',
                    'technologies' => 'Laravel, Next.js, Docker, Render, Vercel',
                    'github_url' => 'https://github.com/tuo-username/tech-portfolio',
                    'live_url' => 'https://tech-portfoglio-new.vercel.app',
                    'featured' => true,
                    'sort_order' => 1,
                ],
                [
                    'title' => 'Progetto di Esempio',
                    'description' => 'Un altro progetto interessante',
                    'technologies' => 'PHP, MySQL, Vue.js',
                    'github_url' => null,
                    'live_url' => null,
                    'featured' => false,
                    'sort_order' => 2,
                ],
            ];

            foreach ($projects as $project) {
                Project::firstOrCreate(['title' => $project['title']], $project);
            }
            $this->command->info('✅ Projects created');
        }

        // Create sample certifications
        if (Certification::count() < 2) {
            $certs = [
                [
                    'name' => 'Laravel Certified Developer',
                    'issuer' => 'Laravel',
                    'date' => '2024-01-01',
                    'credential_url' => null,
                    'sort_order' => 1,
                ],
                [
                    'name' => 'AWS Certified Developer',
                    'issuer' => 'Amazon Web Services',
                    'date' => '2023-06-15',
                    'credential_url' => null,
                    'sort_order' => 2,
                ],
            ];

            foreach ($certs as $cert) {
                Certification::firstOrCreate(['name' => $cert['name']], $cert);
            }
            $this->command->info('✅ Certifications created');
        }

        // Create timeline events
        if (TimelineEvent::count() < 2) {
            $events = [
                [
                    'title' => 'Started Tech Portfolio',
                    'description' => 'Iniziato lo sviluppo del portfolio personale',
                    'date' => '2024-01-01',
                    'type' => 'project',
                    'sort_order' => 1,
                ],
                [
                    'title' => 'Deployed on Render',
                    'description' => 'Backend deployato con successo su Render',
                    'date' => now()->toDateString(),
                    'type' => 'achievement',
                    'sort_order' => 2,
                ],
            ];

            foreach ($events as $event) {
                TimelineEvent::firstOrCreate(['title' => $event['title']], $event);
            }
            $this->command->info('✅ Timeline events created');
        }

        // Create stats
        if (Stat::count() < 4) {
            $stats = [
                ['label' => 'Projects', 'value' => '10+', 'icon' => 'code', 'sort_order' => 1],
                ['label' => 'Certifications', 'value' => '5', 'icon' => 'certificate', 'sort_order' => 2],
                ['label' => 'Years Experience', 'value' => '3+', 'icon' => 'calendar', 'sort_order' => 3],
                ['label' => 'Technologies', 'value' => '15+', 'icon' => 'tools', 'sort_order' => 4],
            ];

            foreach ($stats as $stat) {
                Stat::firstOrCreate(['label' => $stat['label']], $stat);
            }
            $this->command->info('✅ Stats created');
        }

        $this->command->info('');
        $this->command->info('🎉 Database populated successfully!');
        $this->command->info('🔐 Admin login: admin@example.com / password123');
        $this->command->info('⚠️  IMPORTANT: Change the admin password after first login!');
    }
}
